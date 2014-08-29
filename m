Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:38759 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaH2EV3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 00:21:29 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 29 Aug 2014 09:51:27 +0530
Date: Fri, 29 Aug 2014 12:21:21 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bob Biloxi <iambobbiloxi@gmail.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: mlx4 query in sriov mode
Message-ID: <20140829042121.GA31486@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <CANwwZzXowyGmg-cfCHQqeJ_iqjT+Ec+JPy+OWzNGeyN=hRqmPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANwwZzXowyGmg-cfCHQqeJ_iqjT+Ec+JPy+OWzNGeyN=hRqmPg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 28, 2014 at 10:58:50PM +0530, Bob Biloxi wrote:
>Hi All,
>
>
>I really appreciate this wonderful community which has immensely
>helped me broaden my knowledge and understanding.
>
>
>I was going through the mlx4 sriov code, trying to understand the
>communication between the VF driver and the PF driver.
>
>I was having a few queries..hoping to get a better understanding.
>
>
>As I understand, the commands are communicated between VF and PF
>through a mechanism called communication channel. VF writes to
>specific address in its BAR space, PF gets an event and then proceeds
>ahead to read the command from its BAR space and then complete the
>execution of it..
>
>
>Now, my query is, lets say the VF driver is not yet present and only
>the PF driver is there...
>
>In this case, can we simulate a VF command write and get notified
>through an event?
>

Hi,

I am not that familiar with mlx4 driver. As you mentioned in previous, VF
communicate with PF by writing some word in BAR and PF gets it. If this is
true, I believe it would works.

>For eg. we write to some offset in the PF BAR space itself upon
>completion of which, an event is generated because of the write? kind
>of like loopback mechanism.
>
>
>I searched through the code but couldn't find anywhere.
>
>Can anyone please help me understand if this is possible? And if there
>is any location in the code where i can find this?

Where you fund the communication between PF and VF is by writing its BAR?

>
>Thanks a lot in advance!!
>
>
>Best Regards,
>Bob
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

