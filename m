Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44966 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752968AbdKCQmX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Nov 2017 12:42:23 -0400
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171955.lvnvqnwl4qwhlmdk@linutronix.de>
 <b41e83ae-a687-3118-16cb-5ee92e70fc2b@deltatee.com>
 <20171103082227.zzbeee54pd2bf72u@linutronix.de>
 <83b6c876-6595-5b2c-e82c-2f75f559c20b@deltatee.com>
 <20171103161954.557idpkckag7j7j5@linutronix.de>
 <ceab9bab-3c6d-4800-fa44-386e5fe9e71f@deltatee.com>
 <20171103163924.7rtdkkst3yl7ghcm@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d2324e09-4125-c8ec-925b-6de15f37717c@deltatee.com>
Date: Fri, 3 Nov 2017 10:42:22 -0600
MIME-Version: 1.0
In-Reply-To: <20171103163924.7rtdkkst3yl7ghcm@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03/11/17 10:39 AM, Sebastian Andrzej Siewior wrote:
> and this piece is needed to get it working on RT. In longer term we
> would want completions based on simple waitqueues upstream, too.

Well in the longer term it seems like you'd want to make simple 
waitqueues pollable. Then you don't need this patch.

Logan
