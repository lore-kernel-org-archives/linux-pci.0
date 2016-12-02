Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI
 controller for ThunderX pass2.x silicon version
To: Duc Dang <dhdang@apm.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
 <e5b1f09c-ca4c-fbf0-e9d7-c943ad0df2ff@redhat.com>
 <CADaLNDm8Zp_kAqVvSd0po9S3j2rSXxtUJ1M33dW7gLZzvueweQ@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Arnd Bergmann
 <arnd@arndb.de>, Rafael Wysocki <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon
 <will.deacon@arm.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        linux-acpi@vger.kernel.org,
        Robert Richter <robert.richter@caviumnetworks.com>,
        linux-pci@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        Andrea Gallo <andrea.gallo@linaro.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Christopher Covington <cov@codeaurora.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <35d2f3b3-7337-f763-86be-2426d6041251@redhat.com>
Date: Fri, 2 Dec 2016 01:45:59 -0500
MIME-Version: 1.0
In-Reply-To: <CADaLNDm8Zp_kAqVvSd0po9S3j2rSXxtUJ1M33dW7gLZzvueweQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 12/02/2016 01:42 AM, Duc Dang wrote:
> On Thu, Dec 1, 2016 at 9:50 PM, Jon Masters <jcm@redhat.com> wrote:
>> On 11/30/2016 07:28 PM, Bjorn Helgaas wrote:
>>
>>> I'm hoping to end up with something like this:
>>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=51ad4df79a9b7f2a66b346a46b21a785a2937469
>>
>> The following build warnings happen using your branch on RHELSA7.3:
>>
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>>   THUNDER_PEM_QUIRK(2,  0), /* off-chip devices */
>>   ^
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[44].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[44].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[45].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[45].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[46].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[46].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[47].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[47].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[48].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[48].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[49].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ‘mcfg_quirks[49].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>>   THUNDER_PEM_QUIRK(2,  1), /* off-chip devices */
>>   ^
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[50].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[50].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[51].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[51].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[52].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[52].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[53].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[53].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[54].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[54].cfgres.end’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[55].cfgres.start’) [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
>> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ‘mcfg_quirks[55].cfgres.end’) [enabled by default]
> 
> I saw this too. It can be fixed by changes below:
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 7319188..3d7c5cc 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -98,16 +98,16 @@ struct mcfg_fixup {
>         { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
>         &pci_thunder_ecam_ops }
>         /* SoC pass1.x */
> -   THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
> -   THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
> -   THUNDER_ECAM_QUIRK(2,  0),
> -   THUNDER_ECAM_QUIRK(2,  1),
> -   THUNDER_ECAM_QUIRK(2,  2),
> -   THUNDER_ECAM_QUIRK(2,  3),
> -   THUNDER_ECAM_QUIRK(2, 10),
> -   THUNDER_ECAM_QUIRK(2, 11),
> -   THUNDER_ECAM_QUIRK(2, 12),
> -   THUNDER_ECAM_QUIRK(2, 13),
> + THUNDER_PEM_QUIRK(2, 0UL),  /* off-chip devices */
> + THUNDER_PEM_QUIRK(2, 1UL),  /* off-chip devices */
> + THUNDER_ECAM_QUIRK(2, 0UL),
> + THUNDER_ECAM_QUIRK(2, 1UL),
> + THUNDER_ECAM_QUIRK(2, 2UL),
> + THUNDER_ECAM_QUIRK(2, 3UL),
> + THUNDER_ECAM_QUIRK(2, 10UL),
> + THUNDER_ECAM_QUIRK(2, 11UL),
> + THUNDER_ECAM_QUIRK(2, 12UL),
> + THUNDER_ECAM_QUIRK(2, 13UL),
> 
>  #define XGENE_V1_ECAM_MCFG(rev, seg) \
>         {"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \

...which reminds me to followup on that project to get an Intel-style
0-day test service running for arm64. It's been kicking around too long.

-- 
Computer Architect | Sent from my Fedora powered laptop
