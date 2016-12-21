Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 21 Dec 2016 06:26:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: John Crispin <john@phrozen.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] pci: add kernel config option for disabling common PCI
 quirks
Message-ID: <20161221142607.GA8594@infradead.org>
References: <1482306784-29224-1-git-send-email-john@phrozen.org>
 <20161221122213.GA32563@infradead.org>
 <8630ec3a-9424-653c-7c7a-d88554011151@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8630ec3a-9424-653c-7c7a-d88554011151@phrozen.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 21, 2016 at 02:11:25PM +0100, John Crispin wrote:
> I can turn it into an enable patch that is selected by default.
> 
> The current patch disables all those quirks that are used for x86/PC
> style machines and hence are not required in the embedded world.

Maybe we'll just need to reorganize the quirks so that most of them
arch in arch code or the affected drivers?
