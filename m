Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vikas Chaudhary <vikas.chaudhary@qlogic.com>
To: Alexander Gordeev <agordeev@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
CC: Dept-Eng iSCSI Driver <Dept-iSCSIDriver@qlogic.com>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 22/23] qla4xxx: Use pci_enable_msix_exact()
 instead of pci_enable_msix()
Date: Tue, 15 Apr 2014 12:48:35 +0000
Message-ID: <3FC4AB8B47ECD546BCD4B361A64BEACD8C68C56A@avmb3.qlogic.org>
References: <cover.1397461652.git.agordeev@redhat.com>
 <c9fde58b669724b9f1a3e744439b69ca39b5f4bb.1397461652.git.agordeev@redhat.com>
In-Reply-To: <c9fde58b669724b9f1a3e744439b69ca39b5f4bb.1397461652.git.agordeev@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 14/04/14 1:35 pm, "Alexander Gordeev" <agordeev@redhat.com> wrote:

>As result of deprecation of MSI-X/MSI enablement functions
>pci_enable_msix() and pci_enable_msi_block() all drivers
>using these two interfaces need to be updated to use the
>new pci_enable_msi_range()  or pci_enable_msi_exact()
>and pci_enable_msix_range() or pci_enable_msix_exact()
>interfaces.
>
>Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
>Cc: Vikas Chaudhary <vikas.chaudhary@qlogic.com>
>Cc: iscsi-driver@qlogic.com
>Cc: linux-scsi@vger.kernel.org
>Cc: linux-pci@vger.kernel.org
>---
> drivers/scsi/qla4xxx/ql4_nx.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
>index 63328c8..a3e69e6 100644
>--- a/drivers/scsi/qla4xxx/ql4_nx.c
>+++ b/drivers/scsi/qla4xxx/ql4_nx.c
>@@ -3787,7 +3787,7 @@ qla4_8xxx_enable_msix(struct scsi_qla_host *ha)
> 	for (i = 0; i < QLA_MSIX_ENTRIES; i++)
> 		entries[i].entry = qla4_8xxx_msix_entries[i].entry;
> 
>-	ret = pci_enable_msix(ha->pdev, entries, ARRAY_SIZE(entries));
>+	ret = pci_enable_msix_exact(ha->pdev, entries, ARRAY_SIZE(entries));
> 	if (ret) {
> 		ql4_printk(KERN_WARNING, ha,
> 		    "MSI-X: Failed to enable support -- %d/%d\n",
>-- 
>1.7.7.6

Acked-By: Vikas Chaudhary <vikas.chaudhary@qlogic.com>


