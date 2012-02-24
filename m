Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:36051 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741Ab2BXD6P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 22:58:15 -0500
Message-ID: <4F470ABE.2010206@st.com>
Date: Fri, 24 Feb 2012 09:27:50 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
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
References: <1297937650-2558-1-git-send-email-pratyush.anand@st.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0373799132@dbde02.ent.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03737991EA@dbde02.ent.ti.com> <4D78D6E3.50004@st.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03743048FE@dbde02.ent.ti.com> <4D806132.1090704@st.com> <4F460E79.5000308@st.com> <20120223174228.GF22536@google.com>
In-Reply-To: <20120223174228.GF22536@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/23/2012 11:12 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Feb 23, 2012 at 03:31:29PM +0530, Pratyush Anand wrote:
>> Its a long pending patch.
>> Any decision on this patch.
>
> Hmmm.... I really don't know what to do.  IIRC it was something lifted
> from the proprietary sil driver and they probably added that to work
> around performance oddities under certain configurations and I'm a bit
> worried about changing it after all this time.  Is there any way to
> make this conditional somehow?

I see that there is a patch in the latest kernel.

commit a1c473aa11e61bc871be16279c9bf976acf22504
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Fri Oct 14 14:56:15 2011 -0500

     pci: Clamp pcie_set_readrq() when using "performance" settings

I think, this will resolve the issue.
We are moving to the new kernel. Will check it there.

Regards
Pratyush

>
> Thanks.
>

