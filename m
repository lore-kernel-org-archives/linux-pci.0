Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Jon Mason <jdmason@kudzu.us>, D Meyer <dmeyer@gigaio.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        stephen.bates@microsemi.com, Dave Jiang <dave.jiang@intel.com>,
        "Hubbe, Allen" <Allen.Hubbe@emc.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1508271773-17827-1-git-send-email-dmeyer@gigaio.com>
 <CAPoiz9y-6kyjF1ypt7p+7K6E-m55_Fra5hgFYy--5YXz7V2PdQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <03a7e0e1-6863-e1ae-122f-ec630f4209dd@deltatee.com>
Date: Tue, 17 Oct 2017 14:57:53 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9y-6kyjF1ypt7p+7K6E-m55_Fra5hgFYy--5YXz7V2PdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] NTB: ntb_hw_switchtec: Fix peer BAR bug in
 switchtec_ntb_init_shared_mw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 17/10/17 02:25 PM, Jon Mason wrote:
>> Signed-off-by: Doug Meyer <dmeyer@gigaio.com>

Thanks Doug! This looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Fixes: 678784a44ae8 ("NTB: switchtec_ntb: Initialize hardware for memory 
windows")


Logan
