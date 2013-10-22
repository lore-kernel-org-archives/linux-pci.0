Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:56057 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750786Ab3JVEhL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Oct 2013 00:37:11 -0400
Date: Tue, 22 Oct 2013 10:06:53 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Message-ID: <20131022043653.GB2760@pratyush-vbox>
References: <52652BF1.4040507@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <52652BF1.4040507@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Mon, Oct 21, 2013 at 09:28:17PM +0800, Kishon Vijay Abraham I wrote:
> Hi,
> 
> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
> know if in your platform, do you have only 2 address translation regions? In
> DRA7xx we have 16 outbound regions and 4 inbound regions.

I do not know about samsung, Jingoo can confirm. In SPEAr1340 there
are only 2 inbound and outbound viewports, but in SPEAr1310 there are
6. It would be good to modify the driver, to avoid re-use of viewport
whereever possible.

> 
> Also the same designware IP can be used as a EP also no? Shouldn't we move it

Yes same IP can be configured as EP. But..

> out of drivers/pci/host and allow it to be configured as EP also?

Same driver may not be used. (Few of these functions might be reused,
but not whole). Moreover, in my experience  running Linux over an EP
can have only importance of validation/demo. Practical use case will
find a simple firmware more suitable.

Regards
Pratyush

> 
> Thanks
> Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
