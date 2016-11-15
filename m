Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 15 Nov 2016 15:50:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vecu Bosseur <vecu.bosseur@gmail.com>
Cc: linux-pci@vger.kernel.org, linux@vger.kernel.org, helgaas@kernel.org
Subject: Re: PCI: Don't attempt to claim shadow copies of ROM
Message-ID: <20161115145054.GA17120@kroah.com>
References: <CACivvv2UHkqPCj+jzzFGdD-uqDfKgDTsvBRLNRdzeqwWHcYo4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACivvv2UHkqPCj+jzzFGdD-uqDfKgDTsvBRLNRdzeqwWHcYo4Q@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 15, 2016 at 01:53:39PM +0100, Vecu Bosseur wrote:
> Hello,
> 
> Upstream commit 16d917b130d782b94fa02afc7bdf0d4aae689da4 ( PCI: Don't
> attempt to claim shadow copies of ROM ) didn't make it into Greg's
> stable 4.8.8 point release. Was this expected ?

Yes, because 4.8.8-rc1 came out before that commit was in a -rc release
done by Linus.  I can't go back in time to add stuff to 4.8.8...

> When will this fix be picked up ? On next point release or on 4.9
> final release ?

It will be in one of the next few releases, please be patient.

thanks,

greg k-h
