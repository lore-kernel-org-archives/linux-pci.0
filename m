Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:51843 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbdF2TAT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2017 15:00:19 -0400
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-7-logang@deltatee.com>
 <000301d2f103$3310ca60$99325f20$@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        'Serge Semin' <fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
Date: Thu, 29 Jun 2017 13:00:06 -0600
MIME-Version: 1.0
In-Reply-To: <000301d2f103$3310ca60$99325f20$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 06/16] ntb: add check and comment for link up to mw_count
 and mw_get_align
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/29/2017 12:11 PM, Allen Hubbe wrote:
> Nak.  This breaks a work around for stability issues on some hardware.  I am ok with changing the comment to say, this is only supported when called after link up.  I would still like to allow these to be called at any time.  Specific hardware drivers like Switchtec may return an error.  Upstream drivers, of course, should call these after link up: patch 5/16 part of this set looks good.

If absolutely necessary I can leave this out. But in terms of interface 
design it's _so_ much better to have it in. This change would bring the 
score from a 3 to a 5 on Rusty Russel's Hard to Misuse ranking[1]. To 
quote Rusty:

"3. Read the documentation and you'll get it right.
People only read instructions after they've already tied themselves into 
a knot. Then they skim them for keywords and don't read your warnings. I 
don't give an example of this; if this is the best an interface can get 
do, it's in trouble."

Can someone not just fix the out-of-tree code? And since when is 
out-of-tree code reasonable justification for what's done in upstream?

Logan

[1]http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
