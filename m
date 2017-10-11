Return-Path: <SRS0=GcZo=BK=oracle.com=dan.carpenter@kernel.org>
Return-Path: <SRS0=GcZo=BK=oracle.com=dan.carpenter@kernel.org>
Date: Wed, 11 Oct 2017 16:33:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jia-Ju Bai <baijiaju1990@163.com>, devel@driverdev.osuosl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, scott@matheina.com,
        airlied@linux.ie, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, dan.a.cashman@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrik.r.jakobsson@gmail.com, tvboxspy@gmail.com,
        linux-pm@vger.kernel.org, forest@alittletooquiet.net, simon@nikanor.nu,
        bhelgaas@google.com, golubev.mikhail@gmail.com
Subject: Re: [PATCH] pci: Fix a possible sleep-in-atomic bug in
 pci_set_power_state
Message-ID: <20171011133324.b5xnlmj5uhme2ibt@mwanda>
References: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
 <20171009171517.GL25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009171517.GL25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 12:15:17PM -0500, Bjorn Helgaas wrote:
> I assume it's easy to produce an actual failure here?  Why haven't we
> seen bug reports about this?

The bug was detected with static analysis.  You have to enable a debug
feature in the .config if you want sleeping with spinlock held warnings.
Otherwise you'd have to hit the deadlock and you have to be pretty
unlucky to hit it so these bugs sometimes do go unreported for a long
time.

regards,
dan carpenter
