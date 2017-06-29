Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:52113 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbdF2URR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2017 16:17:17 -0400
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-7-logang@deltatee.com>
 <000301d2f103$3310ca60$99325f20$@dell.com>
 <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
 <000401d2f114$3499f2b0$9dcdd810$@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        'Serge Semin' <fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <63c4b0fa-2f03-6313-2d60-c6dab53bc3a5@deltatee.com>
Date: Thu, 29 Jun 2017 14:17:02 -0600
MIME-Version: 1.0
In-Reply-To: <000401d2f114$3499f2b0$9dcdd810$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 06/16] ntb: add check and comment for link up to mw_count
 and mw_get_align
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2017 2:13 PM, Allen Hubbe wrote:
> Unfortunately, it is to work around hardware errata.  That is not so trivial to fix.

Can you describe more what the work around is doing? Can you share the 
code? It seems odd that a workaround is based on the alignment 
restrictions of the mws.

Logan
