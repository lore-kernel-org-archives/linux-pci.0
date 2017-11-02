Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39478 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934407AbdKBUzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Nov 2017 16:55:14 -0400
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171736.rpdlemzw5jueuq5w@linutronix.de>
 <31ed36b3-2328-8cc4-3aea-8c13a39e63bf@deltatee.com>
 <20171102180548.f6sc2edxbvw7qeu7@linutronix.de>
 <2b025b79-b625-dab0-5b68-c77ca0c2bd74@deltatee.com>
 <20171102205306.bk6ykgmdn7gh37mq@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0f0c55dc-591b-e32f-b366-057f254edc11@deltatee.com>
Date: Thu, 2 Nov 2017 14:55:12 -0600
MIME-Version: 1.0
In-Reply-To: <20171102205306.bk6ykgmdn7gh37mq@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02/11/17 02:53 PM, Sebastian Andrzej Siewior wrote:
> It would have made sense if that function would be used also within the
> file where it was declared but it is not the case.
> So you see the questionable way the READ_ONCE got in there and now you
> may understand that I did not see much of big loss if it wasn't there
> after the rewrite/change.

Yes, but I feel like it still makes sense for it to be there (per the 
article I linked), despite the incorrect justification.

Logan
