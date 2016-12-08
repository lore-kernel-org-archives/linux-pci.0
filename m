Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 8 Dec 2016 17:34:33 +0100
From: Robert Richter <robert.richter@cavium.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI
 controller for ThunderX pass2.x silicon version
Message-ID: <20161208163433.GK10776@rric.localdomain>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
 <e5b1f09c-ca4c-fbf0-e9d7-c943ad0df2ff@redhat.com>
 <CADaLNDm8Zp_kAqVvSd0po9S3j2rSXxtUJ1M33dW7gLZzvueweQ@mail.gmail.com>
 <30ad6c65-4a4a-6346-00f6-11250133a251@semihalf.com>
 <20161202104500.GE10776@rric.localdomain>
 <20161202162743.GB9903@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20161202162743.GB9903@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
 Andrea Gallo <andrea.gallo@linaro.org>, Duc Dang <dhdang@apm.com>,
 Jayachandran C <jchandra@broadcom.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Rafael Wysocki <rafael@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 David Daney <ddaney@caviumnetworks.com>, Jeremy Linton <jeremy.linton@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-acpi@vger.kernel.org, Christopher Covington <cov@codeaurora.org>,
 linux-pci@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 02.12.16 10:27:43, Bjorn Helgaas wrote:
> On Fri, Dec 02, 2016 at 11:45:00AM +0100, Robert Richter wrote:
> > On 02.12.16 11:06:24, Tomasz Nowicki wrote:
> > > On 02.12.2016 07:42, Duc Dang wrote:
> > 
> > > >@@ -98,16 +98,16 @@ struct mcfg_fixup {
> > > >        { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
> > > >        &pci_thunder_ecam_ops }
> > > >        /* SoC pass1.x */
> > > >-   THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
> > > >-   THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
> > > >-   THUNDER_ECAM_QUIRK(2,  0),
> > > >-   THUNDER_ECAM_QUIRK(2,  1),
> > > >-   THUNDER_ECAM_QUIRK(2,  2),
> > > >-   THUNDER_ECAM_QUIRK(2,  3),
> > > >-   THUNDER_ECAM_QUIRK(2, 10),
> > > >-   THUNDER_ECAM_QUIRK(2, 11),
> > > >-   THUNDER_ECAM_QUIRK(2, 12),
> > > >-   THUNDER_ECAM_QUIRK(2, 13),
> > > >+ THUNDER_PEM_QUIRK(2, 0UL),  /* off-chip devices */
> > > >+ THUNDER_PEM_QUIRK(2, 1UL),  /* off-chip devices */
> > > >+ THUNDER_ECAM_QUIRK(2, 0UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 1UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 2UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 3UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 10UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 11UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 12UL),
> > > >+ THUNDER_ECAM_QUIRK(2, 13UL),
> > > >
> > > 
> > > The UL suffix is needed for *THUNDER_PEM_QUIRK* only. THUNDER_ECAM_QUIRK is
> > > fine.
> > 
> > We should better make the type cast part of the macro.
> > 
> > + this:
> > 
> > ---
> > #define THUNDER_MCFG_RES(addr, node) \
> >        DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)
> > ---
> > 
> > The args in the macro need parentheses.
> 
> Would you mind sending me a little incremental patch doing what you
> want?  I could try myself, but since I don't have an arm64 cross-build
> setup, I'm working in the dark.

Your current branch looks good.

 5d06f9125ec0 PCI: Explain ARM64 ACPI/MCFG quirk Kconfig and build strategy

Thanks,

-Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
