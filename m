Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65224 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3IFR3n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:29:43 -0400
Received: by mail-ie0-f176.google.com with SMTP id s9so7611801iec.35
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:29:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6-BFtr=HH_5zLUrVK6goiVsNTq5pwmn+_wj4_z9kY-3A@mail.gmail.com>
References: <F5D084D6342F9B479C34599BB0A03E4D020128@AVMB1.qlogic.org>
 <D63B9804CB63AD4FAAD966037695664603A72C@avmb2.qlogic.org> <CAErSpo6rs2+Sp3WrqsH7DXb+uZ=c7z8YnT1-GpCd96kKNW1_-w@mail.gmail.com>
 <CAErSpo6-BFtr=HH_5zLUrVK6goiVsNTq5pwmn+_wj4_z9kY-3A@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 6 Sep 2013 11:29:22 -0600
Message-ID: <CAErSpo56eEdm2fn3CSjMvhcA+p+ZbhqGA67Vibyb7rTtOjRf9w@mail.gmail.com>
Subject: Re: [PATCH 04/12] [SCSI] qla2xxx: Use standard PCIe Capability Link
 register field names
To: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Giridhar Malavali <giridhar.malavali@qlogic.com>,
	Saurav Kashyap <saurav.kashyap@qlogic.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Dept-Eng Linux Driver <Linux-Driver@qlogic.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry, I said I was going to push this through my PCI tree, but I
forgot all about it.  I put it (finally) in my pci/misc branch, and
will merge it during the v3.13 merge window.

On Fri, Jan 4, 2013 at 12:31 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I haven't heard anything, so I'm going to push this through the PCI
> tree.  Let me know if anybody objects or would like to handle it
> differently.
>
> On Mon, Dec 17, 2012 at 12:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Ping.  I didn't push this through my tree because I didn't want to
>> create conflicts with other changes to this file.  But I think this
>> can be merged any time.
>>
>> On Fri, Dec 7, 2012 at 3:29 PM, Giridhar Malavali
>> <giridhar.malavali@qlogic.com> wrote:
>>> Acked-by: Giridhar Malavali
>>>
>>> On 12/7/12 12:17 AM, "Saurav Kashyap" <saurav.kashyap@qlogic.com> wrote:
>>>
>>>>Acked-by: Saurav Kashyap <saurav.kashyap@qlogic.com>
>>>>
>>>>Thanks,
>>>>~Saurav
>>>>
>>>>
>>>>
>>>>>Use the standard #defines for PCIe Link Capability register fields
>>>>>rather than bare numbers.  This also uses the new PCI Express Capability
>>>>>accessor rather than reading the capability directly.
>>>>>
>>>>>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>CC: Andrew Vasquez <andrew.vasquez@qlogic.com>
>>>>>CC: linux-driver@qlogic.com
>>>>>CC: "James E.J. Bottomley" <JBottomley@parallels.com>
>>>>>CC: linux-scsi@vger.kernel.org
>>>>>---
>>>>> drivers/scsi/qla2xxx/qla_os.c |   14 +++++---------
>>>>> 1 files changed, 5 insertions(+), 9 deletions(-)
>>>>>
>>>>>diff --git a/drivers/scsi/qla2xxx/qla_os.c
>>>>>b/drivers/scsi/qla2xxx/qla_os.c
>>>>>index d501bf5..b5d070f 100644
>>>>>--- a/drivers/scsi/qla2xxx/qla_os.c
>>>>>+++ b/drivers/scsi/qla2xxx/qla_os.c
>>>>>@@ -480,18 +480,14 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha,
>>>>>char *str)
>>>>>      static char *pci_bus_modes[] = { "33", "66", "100", "133", };
>>>>>      struct qla_hw_data *ha = vha->hw;
>>>>>      uint32_t pci_bus;
>>>>>-     int pcie_reg;
>>>>>
>>>>>-     pcie_reg = pci_pcie_cap(ha->pdev);
>>>>>-     if (pcie_reg) {
>>>>>+     if (pci_is_pcie(ha->pdev)) {
>>>>>              char lwstr[6];
>>>>>-             uint16_t pcie_lstat, lspeed, lwidth;
>>>>>+             uint32_t lstat, lspeed, lwidth;
>>>>>
>>>>>-             pcie_reg += PCI_EXP_LNKCAP;
>>>>>-             pci_read_config_word(ha->pdev, pcie_reg, &pcie_lstat);
>>>>>-             lspeed = pcie_lstat & (BIT_0 | BIT_1 | BIT_2 | BIT_3);
>>>>>-             lwidth = (pcie_lstat &
>>>>>-                 (BIT_4 | BIT_5 | BIT_6 | BIT_7 | BIT_8 | BIT_9)) >> 4;
>>>>>+             pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
>>>>>+             lspeed = lstat & PCI_EXP_LNKCAP_SLS;
>>>>>+             lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
>>>>>
>>>>>              strcpy(str, "PCIe (");
>>>>>              if (lspeed == 1)
>>>>>
>>>>>--
>>>>>To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>>>>>the body of a message to majordomo@vger.kernel.org
>>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>
>>>
