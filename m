Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44897 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2BXFjb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 00:39:31 -0500
From: "Pedanekar, Hemant" <hemantp@ti.com>
To: Pratyush Anand <pratyush.anand@st.com>, Tejun Heo <tj@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Viresh KUMAR <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	Rajeev KUMAR <rajeev-dlh.kumar@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	Amit VIRDI <Amit.VIRDI@st.com>,
	Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: [PATCH] PCIE: pcie_set_readrq must not be allowed by PCIE EP
 driver
Date: Fri, 24 Feb 2012 05:38:20 +0000
Message-ID: <DDE393F022194E4FB9AE108B0AECD70C317CA30B@DBDE01.ent.ti.com>
References: <1297937650-2558-1-git-send-email-pratyush.anand@st.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0373799132@dbde02.ent.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03737991EA@dbde02.ent.ti.com>
 <4D78D6E3.50004@st.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03743048FE@dbde02.ent.ti.com>
 <4D806132.1090704@st.com> <4F460E79.5000308@st.com>
 <20120223174228.GF22536@google.com> <4F470ABE.2010206@st.com>
In-Reply-To: <4F470ABE.2010206@st.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Pratyush Anand wrote on Friday, February 24, 2012 9:28 AM:

> On 2/23/2012 11:12 PM, Tejun Heo wrote:
>> Hello,
>> 
>> On Thu, Feb 23, 2012 at 03:31:29PM +0530, Pratyush Anand wrote:
>>> Its a long pending patch.
>>> Any decision on this patch.
>> 
>> Hmmm.... I really don't know what to do.  IIRC it was something lifted
>> from the proprietary sil driver and they probably added that to work
>> around performance oddities under certain configurations and I'm a bit
>> worried about changing it after all this time.  Is there any way to
>> make this conditional somehow?
> 
> I see that there is a patch in the latest kernel.
> 
> commit a1c473aa11e61bc871be16279c9bf976acf22504
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Fri Oct 14 14:56:15 2011 -0500
> 
>      pci: Clamp pcie_set_readrq() when using "performance" settings
> 
> I think, this will resolve the issue.
> We are moving to the new kernel. Will check it there.
> 
I see that the patch above considers MPS to clamp RRQ size, while I think
both should be independent, or perhaps I am missing something. 

Not allowing EP drivers to choose max RRQ setting for their respective 
devices will prevent breaking the mismatches where EP sends RRQ which RC 
cannot handle.

Other option is that the EP drivers which force max RRQ size also handle
the case where they get completor abort (or it wil be UR?) from the 
completor and then try to use lower (or lowest) read request. This will 
prevent breaking the data paths at the same time allowing systems which are
capable to have max performance.

Thanks.

   Hemant