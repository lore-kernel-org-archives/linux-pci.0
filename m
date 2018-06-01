Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 1 Jun 2018 13:53:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2] PCI: move early dump functionality from x86 arch into
 the common code
Message-ID: <20180601185310.GA175802@bhelgaas-glaptop.roam.corp.google.com>
References: <1527878854-21419-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1527878854-21419-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Petr Tesarik <ptesarik@suse.cz>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 timur@codeaurora.org,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Ram Pai <linuxram@us.ibm.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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

On Fri, Jun 01, 2018 at 02:47:28PM -0400, Sinan Kaya wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.

> +static void early_dump_pci_device(struct pci_dev *pdev)
> +{
> +	u32 value[256 / 4];
> +	int i;
> +
> +	if (!pci_early_dump)
> +		return;
> +
> +	pci_info(pdev, "pci 0000:%02x:%02x.%d config space:\n",
> +		 pdev->bus->number, PCI_SLOT(pdev->devfn),
> +		 PCI_FUNC(pdev->devfn));

I'm still missing something -- why go to the trouble of pdev->bus->number,
PCI_SLOT(), etc?  Isn't the output going to look like this?

  pci 0000:00:00.0: pci 0000:00:00.0 config space:

In other words, wouldn't the following be enough?

  pci_info(pdev, "config space:\n");

> +
> +	for (i = 0; i < 256; i += 4)
> +		pci_read_config_dword(pdev, i, &value[i / 4]);
> +
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
> +		       256, false);
> +}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
