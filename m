Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44517 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbaAHPtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 10:49:02 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Pratyush Anand <pratyush.anand@st.com>
CC: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Subject: RE: pcie designware question
Date: Wed, 8 Jan 2014 15:48:52 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704663866@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B70465DDAD@DFLE11.ent.ti.com>
 <CAErSpo67jb3MhvoiWKtgymjoz-E3xreRuec8NsO_Mfo7QTiHFw@mail.gmail.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F96BAC51@EAPEX1MAIL1.st.com>
 <52B46E4D.6020805@ti.com> <20140108065535.GC2689@pratyush-vbox>
In-Reply-To: <20140108065535.GC2689@pratyush-vbox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Mohit,
>>
>> I have checked with our hardware team and they confirmed that ATU
>> registers are not implemented in our PCIE
>
>Which PCIe designware IP version you are using? At least since version 3.71 support of
>viewport is available in IP. Older version was handling address translation using side band
>signals implemented through vendor specific application registers. May be your case is also
>similar.
>
Pratyush,

Thanks for responding.

Is there a register that I can poke to know the IP version. I have asked this to our
hardware folks to know the version. I guess it is older than 3.71.

>> SS. So we need to have  a way to disable this in the core driver so
>> that  we can handle it in our glue layer driver.
>> But this will be a regression on the existing driver. How do we handle this?
>
>May be you can add rd/wr_other_conf in struct pcie_host_ops.
>Change designware driver to handle vendor specific rd/wr_other_conf, if it exists, else use
>generic rd/wr_other_conf.
>
Yes, that is indeed what I did to solve this. I will be sending a patch for this once
my driver is tested.

Murali
>In your vendor specific rd/wr_other_conf handler you can implement translation using your
>application registers.
>
>Regards
>Pratyush
>>
>> Murali
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
