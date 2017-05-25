Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37125 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033988AbdEYUUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2017 16:20:35 -0400
Received: by mail-wm0-f46.google.com with SMTP id d127so112010862wmf.0
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2017 13:20:34 -0700 (PDT)
Date: Thu, 25 May 2017 21:17:42 +0100
From: Piotr Gregor <piotrgregor@rsyncme.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankede@nvidia.com>,
        Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Move test of INTx masking to pci_setup_device
Message-ID: <20170525201741.GA14175@westernst>
References: <20170525181321.GA13617@westernst>
 <20170525211833-mutt-send-email-mst@kernel.org>
 <20170525123839.6d296856@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525123839.6d296856@w520.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Very good suggestions. Will be reflected in changed patch.
