Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 18:02:31 +0300
Message-ID: <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com>
Subject: Re: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
To: Sinan Kaya <okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, Petr Tesarik <ptesarik@suse.cz>,
 Ram Pai <linuxram@us.ibm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Timur Tabi <timur@codeaurora.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 7:34 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.

>  /* If set, the PCIe ATS capability will not be used. */
>  static bool pcie_ats_disabled;
>
> +bool pci_early_dump;
> +

I didn't check above these, but maybe a good idea to add one line
comment what is this about?


>  extern const unsigned char pcie_link_speed[];
> -
> +extern bool pci_early_dump;
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>

Hmm... I would rather not attach this line to some function declarations.

> +static void early_dump_pci_device(struct pci_dev *pdev)
> +{
> +       u32 value[256 / 4];
> +       int i;
> +
> +       dev_info(&pdev->dev, "pci 0000:%02x:%02x.%d config space:\n",
> +                pdev->bus->number, PCI_SLOT(pdev->devfn),
> +                PCI_FUNC(pdev->devfn));

Shouldn't be this changed to pci_info() ?

> +
> +       for (i = 0; i < 256; i += 4)
> +               pci_read_config_dword(pdev, i, &value[i / 4]);
> +
> +       print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
> +                      256, false);
> +}

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
