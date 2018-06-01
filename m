Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
To: linux-pci@vger.kernel.org, timur@codeaurora.org
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <82d0852b-7c34-3fc2-85d8-c21b33aa8cf4@codeaurora.org>
Date: Fri, 1 Jun 2018 10:45:58 -0400
MIME-Version: 1.0
In-Reply-To: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Petr Tesarik <ptesarik@suse.cz>, Ram Pai <linuxram@us.ibm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Dou Liyang <douly.fnst@cn.fujitsu.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 5/30/2018 12:34 AM, Sinan Kaya wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/x86/include/asm/pci-direct.h               |  5 ---
>  arch/x86/kernel/setup.c                         |  5 ---
>  arch/x86/pci/common.c                           |  4 --
>  arch/x86/pci/early.c                            | 50 -------------------------
>  drivers/pci/pci.c                               |  4 ++
>  drivers/pci/pci.h                               |  2 +-
>  drivers/pci/probe.c                             | 19 ++++++++++
>  8 files changed, 25 insertions(+), 66 deletions(-)

Any feedback on the direction?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
