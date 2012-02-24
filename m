Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:35114 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754230Ab2BXGJo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 01:09:44 -0500
Message-ID: <4F472990.2010304@st.com>
Date: Fri, 24 Feb 2012 11:39:20 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: Tejun Heo <tj@kernel.org>,
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
References: <1297937650-2558-1-git-send-email-pratyush.anand@st.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0373799132@dbde02.ent.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03737991EA@dbde02.ent.ti.com> <4D78D6E3.50004@st.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03743048FE@dbde02.ent.ti.com> <4D806132.1090704@st.com> <4F460E79.5000308@st.com> <20120223174228.GF22536@google.com> <4F470ABE.2010206@st.com> <DDE393F022194E4FB9AE108B0AECD70C317CA30B@DBDE01.ent.ti.com>
In-Reply-To: <DDE393F022194E4FB9AE108B0AECD70C317CA30B@DBDE01.ent.ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/24/2012 11:08 AM, Pedanekar, Hemant wrote:
> Hi,
>
> Pratyush Anand wrote on Friday, February 24, 2012 9:28 AM:
>
>> On 2/23/2012 11:12 PM, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Thu, Feb 23, 2012 at 03:31:29PM +0530, Pratyush Anand wrote:
>>>> Its a long pending patch.
>>>> Any decision on this patch.
>>>
>>> Hmmm.... I really don't know what to do.  IIRC it was something lifted
>>> from the proprietary sil driver and they probably added that to work
>>> around performance oddities under certain configurations and I'm a bit
>>> worried about changing it after all this time.  Is there any way to
>>> make this conditional somehow?
>>
>> I see that there is a patch in the latest kernel.
>>
>> commit a1c473aa11e61bc871be16279c9bf976acf22504
>> Author: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Date:   Fri Oct 14 14:56:15 2011 -0500
>>
>>       pci: Clamp pcie_set_readrq() when using "performance" settings
>>
>> I think, this will resolve the issue.
>> We are moving to the new kernel. Will check it there.
>>
> I see that the patch above considers MPS to clamp RRQ size, while I think
> both should be independent, or perhaps I am missing something.
>

Please also see following patch for completeness.

commit b03e7495a862b028294f59fc87286d6d78ee7fa1
Author: Jon Mason <mason@myri.com>
Date:   Wed Jul 20 15:20:54 2011 -0500

     PCI: Set PCI-E Max Payload Size on fabric

Regards
Pratyush
