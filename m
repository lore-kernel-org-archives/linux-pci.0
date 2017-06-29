Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:51761 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbdF2Sh7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2017 14:37:59 -0400
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-13-logang@deltatee.com>
 <000201d2f103$2f3d2d20$8db78760$@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        'Serge Semin' <fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9a280b29-4e1b-cf4a-54c2-25a522834879@deltatee.com>
Date: Thu, 29 Jun 2017 12:37:46 -0600
MIME-Version: 1.0
In-Reply-To: <000201d2f103$2f3d2d20$8db78760$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 12/16] switchtec_ntb: add link management
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2017 12:11 PM, Allen Hubbe wrote:

> Should we only set self_partition?  I think each peer should be able to set preferred speed, and negotiate down.  As written here, the last peer to set the speed overrides the setting on the peer, and even that is not atomic if they race.

This function isn't actually setting the link speed. (Though I can 
understand the confusion from the name.) It's just reporting the slowest 
speed on the link between the peers for the link_is_up function. (Each 
port will have negotiated it's own speed).

I don't think switchtec has the ability to actually change the port 
speed or width. (Seeing they are negotiated on boot).

Logan
