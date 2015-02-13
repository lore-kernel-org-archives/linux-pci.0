Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:37608 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbbBMCJI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Feb 2015 21:09:08 -0500
Message-ID: <54DD5CAF.9040006@mm-sol.com>
Date: Fri, 13 Feb 2015 04:08:47 +0200
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of
 platform_driver_register
References: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru> <CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com> <54DB0A52.4090907@mm-sol.com> <CAJs94EYS003e_j0S4rzKFEL=PqCqEmT7yd0qdJdnMrziE1700Q@mail.gmail.com> <54DB1EAC.3060302@mm-sol.com> <CAJs94EYNs9+Ph3EXZLPEepWJxU_ivXp=Tifq=LkJZ3mwk1fG3g@mail.gmail.com>
In-Reply-To: <CAJs94EYNs9+Ph3EXZLPEepWJxU_ivXp=Tifq=LkJZ3mwk1fG3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 02/12/2015 11:07 AM, Matwey V. Kornilov wrote:
> 2015-02-11 12:19 GMT+03:00 Stanimir Varbanov <svarbanov@mm-sol.com>:
>> please don't top posting.
>>
>> On 02/11/2015 10:38 AM, Matwey V. Kornilov wrote:HI
>>
>>> It sounds reasonable, but does current implementation support deferring?
>>
>>thor
>> yes, it uses deferred probe see devm_phy_get() and devm_clk_get() calls in
>> .probe and how the returned values are checked.
>>
>>> Struct  spear13xx_pcie_driver just dissapears from memory after init.
>>
>>
>> IMO this is expected because spear13xx_pcie_driver is annotated as
>> __initdata.
> 
> The question was how deferred probe had been expected to work? When
> probe has been deferred at first attempt, then second attempt
> performed after init section, so proble() function must be available,at
> but it is not. Isn't it?
> 

That is questionable, maybe it works by chance?.


regards,
Stan
