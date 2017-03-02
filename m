Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:41772
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751619AbdCBPYw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Mar 2017 10:24:52 -0500
Subject: [RFC PATCH v2 31/32] kvm: svm: Add support for SEV LAUNCH_MEASURE
 command
From: Brijesh Singh <brijesh.singh@amd.com>
To: <simon.guinot@sequanux.org>, <linux-efi@vger.kernel.org>,
        <brijesh.singh@amd.com>, <kvm@vger.kernel.org>,
        <rkrcmar@redhat.com>, <matt@codeblueprint.co.uk>,
        <linux-pci@vger.kernel.org>, <linus.walleij@linaro.org>,
        <gary.hook@amd.com>, <linux-mm@kvack.org>,
        <paul.gortmaker@windriver.com>, <hpa@zytor.com>, <cl@linux.com>,
        <dan.j.williams@intel.com>, <aarcange@redhat.com>,
        <sfr@canb.auug.org.au>, <andriy.shevchenko@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <bhe@redhat.com>,
        <xemul@parallels.com>, <joro@8bytes.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <piotr.luc@intel.com>, <mingo@redhat.com>,
        <msalter@redhat.com>, <ross.zwisler@linux.intel.com>, <bp@suse.de>,
        <dyoung@redhat.com>, <thomas.lendacky@amd.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <arnd@arndb.de>, <toshi.kani@hpe.com>,
        <mathieu.desnoyers@efficios.com>, <luto@kernel.org>,
        <devel@linuxdriverproject.org>, <bhelgaas@google.com>,
        <tglx@linutronix.de>, <mchehab@kernel.org>,
        <iamjoonsoo.kim@lge.com>, <labbott@fedoraproject.org>,
        <tony.luck@intel.com>, <alexandre.bounine@idt.com>,
        <kuleshovmail@gmail.com>, <linux-kernel@vger.kernel.org>,
        <mcgrof@kernel.org>, <mst@redhat.com>,
        <linux-crypto@vger.kernel.org>, <tj@kernel.org>,
        <pbonzini@redhat.com>, <akpm@linux-foundation.org>,
        <davem@davemloft.net>
Date: Thu, 2 Mar 2017 10:18:40 -0500
Message-ID: <148846791999.2349.16796756305829956919.stgit@brijesh-build-machine>
In-Reply-To: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The command is used to retrieve the measurement of memory encrypted through
the LAUNCH_UPDATE_DATA command. This measurement can be used for attestation
purposes.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 64899ed..13996d6 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6141,6 +6141,54 @@ static int sev_dbg_encrypt(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	int ret;
+	void *addr = NULL;
+	struct kvm_sev_launch_measure params;
+	struct sev_data_launch_measure *data;
+
+	if (!sev_guest(kvm))
+		return -ENOTTY;
+
+	if (copy_from_user(&params, (void *)argp->data,
+				sizeof(struct kvm_sev_launch_measure)))
+		return -EFAULT;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (params.address && params.length) {
+		ret = -EFAULT;
+		addr = kzalloc(params.length, GFP_KERNEL);
+		if (!addr)
+			goto err_1;
+		data->address = __psp_pa(addr);
+		data->length = params.length;
+	}
+
+	data->handle = sev_get_handle(kvm);
+	ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_MEASURE, data, &argp->error);
+
+	/* copy the measurement to userspace */
+	if (addr &&
+		copy_to_user((void *)params.address, addr, params.length)) {
+		ret = -EFAULT;
+		goto err_1;
+	}
+
+	params.length = data->length;
+	if (copy_to_user((void *)argp->data, &params,
+				sizeof(struct kvm_sev_launch_measure)))
+		ret = -EFAULT;
+
+	kfree(addr);
+err_1:
+	kfree(data);
+	return ret;
+}
+
 static int amd_memory_encryption_cmd(struct kvm *kvm, void __user *argp)
 {
 	int r = -ENOTTY;
@@ -6176,6 +6224,10 @@ static int amd_memory_encryption_cmd(struct kvm *kvm, void __user *argp)
 		r = sev_dbg_encrypt(kvm, &sev_cmd);
 		break;
 	}
+	case KVM_SEV_LAUNCH_MEASURE: {
+		r = sev_launch_measure(kvm, &sev_cmd);
+		break;
+	}
 	default:
 		break;
 	}
