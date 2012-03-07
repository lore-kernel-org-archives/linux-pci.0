Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 6 Mar 2012 21:48:59 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	jbarnes@virtuousgeek.org, stable@kernel.org
Subject: Re: [PATCH] Ignore pre-1.1 ASPM quirking when ASPM is disabled
Message-ID: <20120307054859.GB7775@kroah.com>
References: <1331059309-4335-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331059309-4335-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 06, 2012 at 01:41:49PM -0500, Matthew Garrett wrote:
> Right now we won't touch ASPM state if ASPM is disabled, except in the case
> where we find a device that appears to be too old to reliably support ASPM.
> Right now we'll clear it in that case, which is almost certainly the wrong
> thing to do. The easiest way around this is just to disable the blacklisting
> when ASPM is disabled.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Cc: stable@kernel.org

That's <stable@vger.kernel.org> if we want to get it right :)

Anyway, Jesse, this needs to get into 3.3-final to prevent
regressions...

thanks,

greg k-h
