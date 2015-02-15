Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63282 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbbBONQe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Feb 2015 08:16:34 -0500
MIME-Version: 1.0
In-Reply-To: <54DD5CAF.9040006@mm-sol.com>
References: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru>
 <CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com>
 <54DB0A52.4090907@mm-sol.com> <CAJs94EYS003e_j0S4rzKFEL=PqCqEmT7yd0qdJdnMrziE1700Q@mail.gmail.com>
 <54DB1EAC.3060302@mm-sol.com> <CAJs94EYNs9+Ph3EXZLPEepWJxU_ivXp=Tifq=LkJZ3mwk1fG3g@mail.gmail.com>
 <54DD5CAF.9040006@mm-sol.com>
From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date: Sun, 15 Feb 2015 17:16:12 +0400
Message-ID: <CAJs94EbeyuZjpMWo2UnYgEVLnj-o2NZu-e_B2bo7bepqxo67Hw@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of platform_driver_register
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-02-13 5:08 GMT+03:00 Stanimir Varbanov <svarbanov@mm-sol.com>:
> Hi,
>
> On 02/12/2015 11:07 AM, Matwey V. Kornilov wrote:
>> 2015-02-11 12:19 GMT+03:00 Stanimir Varbanov <svarbanov@mm-sol.com>:
>>> please don't top posting.
>>>
>>> On 02/11/2015 10:38 AM, Matwey V. Kornilov wrote:HI
>>>
>>>> It sounds reasonable, but does current implementation support deferring?
>>>
>>>thor
>>> yes, it uses deferred probe see devm_phy_get() and devm_clk_get() calls in
>>> .probe and how the returned values are checked.
>>>
>>>> Struct  spear13xx_pcie_driver just dissapears from memory after init.
>>>
>>>
>>> IMO this is expected because spear13xx_pcie_driver is annotated as
>>> __initdata.
>>
>> The question was how deferred probe had been expected to work? When
>> probe has been deferred at first attempt, then second attempt
>> performed after init section, so proble() function must be available,at
>> but it is not. Isn't it?
>>
>
> That is questionable, maybe it works by chance?.

Or maybe it doesn't work at all.


-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
