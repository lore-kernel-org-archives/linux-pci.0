Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:33170 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753101AbdFPOKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 10:10:24 -0400
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        'Serge Semin' <fancer.lancer@gmail.com>,
        Sergey.Semin@t-platforms.ru
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
Date: Fri, 16 Jun 2017 08:09:55 -0600
MIME-Version: 1.0
In-Reply-To: <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 07:53 AM, Allen Hubbe wrote:
> See what is staged in https://github.com/jonmason/ntb.git ntb-next, with the addition of multi-peer support by Serge.  It would be good at this stage to understand whether the api changes there would also support the Switchtec driver, and what if anything must change, or be planned to change, to support the Switchtec driver.

Ah, yes I had seen that patchset some time ago but I wasn't aware of
it's status or that it was queued up in ntb-next. I think it will be no
problem to reconcile with the switchtec driver and I'll rebase onto
ntb-next for the next posting of the patch set. However, I *may* save
full multi-host switchtec support for a follow up submission. My initial
impression is the new API will support the switchtec hardware well.

Thanks,

Logan
