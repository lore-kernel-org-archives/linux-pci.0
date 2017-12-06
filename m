Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:59456 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbdLFRhO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 12:37:14 -0500
To: Arnd Bergmann <arnd@arndb.de>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Stephen Bates <sbates@raithlin.com>,
        Colin Ian King <colin.king@canonical.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <kelvin.cao@microsemi.com>,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20171206141923.817850-1-arnd@arndb.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6cdab766-60a2-0ef9-5495-f842acde8604@deltatee.com>
Date: Wed, 6 Dec 2017 10:37:06 -0700
MIME-Version: 1.0
In-Reply-To: <20171206141923.817850-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] ntb_hw_switchtec: fix logic error
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey,

Thanks, nice catch.

On 06/12/17 07:19 AM, Arnd Bergmann wrote:
> Newer gcc (version 7 and 8 presumably) warn about a statement mixing
> the << operator with logical and:
> 
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c: In function 'switchtec_ntb_init_sndev':
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:888:24: error: '<<' in boolean context, did you mean '<' ? [-Werror=int-in-bool-context]
> 
> My interpretation here is that the author must have intended a bitmask
> rather than a comparison, so I'm changing the '&&' to '&', which makes
> a lot more sense in the context.
> 
> Fixes: 1b249475275d ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
