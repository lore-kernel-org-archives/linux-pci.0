Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51705 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2BWRmd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 12:42:33 -0500
Received: by pbcun15 with SMTP id un15so1653606pbc.19
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 09:42:32 -0800 (PST)
Date: Thu, 23 Feb 2012 09:42:28 -0800
From: Tejun Heo <tj@kernel.org>
To: Pratyush Anand <pratyush.anand@st.com>
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
Message-ID: <20120223174228.GF22536@google.com>
References: <1297937650-2558-1-git-send-email-pratyush.anand@st.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0373799132@dbde02.ent.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03737991EA@dbde02.ent.ti.com>
 <4D78D6E3.50004@st.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03743048FE@dbde02.ent.ti.com>
 <4D806132.1090704@st.com>
 <4F460E79.5000308@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F460E79.5000308@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, Feb 23, 2012 at 03:31:29PM +0530, Pratyush Anand wrote:
> Its a long pending patch.
> Any decision on this patch.

Hmmm.... I really don't know what to do.  IIRC it was something lifted
from the proprietary sil driver and they probably added that to work
around performance oddities under certain configurations and I'm a bit
worried about changing it after all this time.  Is there any way to
make this conditional somehow?

Thanks.

-- 
tejun
