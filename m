Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965120AbcJ0OB7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Oct 2016 10:01:59 -0400
Date: Thu, 27 Oct 2016 12:30:11 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick Kerkhof <rick.2889@gmail.com>
Cc: Peter Wu <peter@lekensteyn.nl>, linux-acpi@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161027093011.GZ1476@lahna.fi.intel.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al>
 <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 27, 2016 at 09:15:19AM +0000, Rick Kerkhof wrote:
>    I can confirm what Peter said, path contains \_SB_.PCI0.RP05 and
>    power_state contains D3hot.

And there are no power_resources_Dx directories under
/sys/bus/pci/devices/0000:00:1c.4/firmware_node?
