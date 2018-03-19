Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:42732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbeCSIrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 04:47:00 -0400
Date: Mon, 19 Mar 2018 11:46:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in new_pcichild_device
Message-ID: <20180319084645.pruplfsgctqfs5wk@mwanda>
References: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks ok.

regards,
dan carpenter
