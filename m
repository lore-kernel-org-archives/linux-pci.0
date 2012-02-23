Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:43492 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265Ab2BWKBw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 05:01:52 -0500
Message-ID: <4F460E79.5000308@st.com>
Date: Thu, 23 Feb 2012 15:31:29 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: <tj@kernel.org>
Cc: "Pedanekar, Hemant" <hemantp@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Viresh KUMAR <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	Rajeev KUMAR <rajeev-dlh.kumar@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	Amit VIRDI <Amit.VIRDI@st.com>,
	Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: Re: [PATCH] PCIE: pcie_set_readrq must not be allowed by PCIE EP
 driver
References: <1297937650-2558-1-git-send-email-pratyush.anand@st.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0373799132@dbde02.ent.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03737991EA@dbde02.ent.ti.com> <4D78D6E3.50004@st.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03743048FE@dbde02.ent.ti.com> <4D806132.1090704@st.com>
In-Reply-To: <4D806132.1090704@st.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tejun,

Its a long pending patch.
Any decision on this patch.

Regards
Pratyush

On 3/16/2011 12:35 PM, pratyush wrote:
> Hello Hemant,
>
> On 3/16/2011 9:43 AM, Pedanekar, Hemant wrote:
>>> What happens in your case? Does it not work, if you do not
>>>> modify sil driver?
>>>>
>> I also require to modify the sil driver to avoid setting max RRQ to 4096
>> otherwise the data transfer over PCIe does not work. The RC responds with
>> "Unsupported Request" for read request of size greater than 256 bytes.
>>
>> The other problem is, there is no way for peers to know that the other
>> device cannot handle RRQ of size beyond certain limit. At least I am not
>> aware of any bits in PCIe configuration space which advertise this. Do you
>> know of any such?
>>
>> While, there is "Max RRQ size" field in device control register which only
>> controls outbound RRQ size.
>>
>> This restriction probbaly will complicate more when the device with such
>> RRQ limitation is a EP, in such case, no one else than the EP (and its driver)
>> would know about this limitation and need to force others (including RC) to
>> reduce the max RRQ size.
>>
>
> Yes, I am agreed with you. I do not see any way to inform its peers about request
> limit. So I think that a EP driver should not be allowed to call any function which
> changes EP's RRQ size. It should always be RC driver which sets these values as
> per max capability of the link.
>
> Currently I am managing it with postinit hook of RC driver. But can be part of
> common pci stack.
>
> You can see my way of handling it at
> http://www.spinics.net/lists/linux-pci/msg09897.html
>
> Regards
> Pratyush

