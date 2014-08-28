Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51846 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaH1R2w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Aug 2014 13:28:52 -0400
MIME-Version: 1.0
Date: Thu, 28 Aug 2014 22:58:50 +0530
Message-ID: <CANwwZzXowyGmg-cfCHQqeJ_iqjT+Ec+JPy+OWzNGeyN=hRqmPg@mail.gmail.com>
Subject: mlx4 query in sriov mode
From: Bob Biloxi <iambobbiloxi@gmail.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,


I really appreciate this wonderful community which has immensely
helped me broaden my knowledge and understanding.


I was going through the mlx4 sriov code, trying to understand the
communication between the VF driver and the PF driver.

I was having a few queries..hoping to get a better understanding.


As I understand, the commands are communicated between VF and PF
through a mechanism called communication channel. VF writes to
specific address in its BAR space, PF gets an event and then proceeds
ahead to read the command from its BAR space and then complete the
execution of it..


Now, my query is, lets say the VF driver is not yet present and only
the PF driver is there...

In this case, can we simulate a VF command write and get notified
through an event?

For eg. we write to some offset in the PF BAR space itself upon
completion of which, an event is generated because of the write? kind
of like loopback mechanism.


I searched through the code but couldn't find anywhere.

Can anyone please help me understand if this is possible? And if there
is any location in the code where i can find this?

Thanks a lot in advance!!


Best Regards,
Bob
