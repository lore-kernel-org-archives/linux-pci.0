Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:54578 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdKVSxy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Nov 2017 13:53:54 -0500
To: Joe Perches <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171121225945.29377-1-colin.king@canonical.com>
 <1511320389.6989.44.camel@perches.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b499bccf-fbac-cab6-f9d2-2edecfac2330@deltatee.com>
Date: Wed, 22 Nov 2017 11:53:47 -0700
MIME-Version: 1.0
In-Reply-To: <1511320389.6989.44.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] NTB: switchtec_ntb: fix spelling mistake: "peforming" ->
 "performing"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 21/11/17 08:13 PM, Joe Perches wrote:
> probably nicer to add the missing newlines too.

Oh, my mistake.

I was never sure what was correct so I think I've been pretty lax about 
that. I'll clean that up.

Seems like something that should be added to checkpatch. I may attempt a 
patch for that.

Thanks,

Logan
