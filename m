Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Oct 2014 20:16:15 -0500
From: Jeff Epler <jepler@unpythonic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: incompatible pci sysfs change since 3.12 (5136b2da770d)
Message-ID: <20141030011615.GB59253@unpythonic.net>
References: <20141030002258.GA59253@unpythonic.net>
 <20141030003657.GA5487@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141030003657.GA5487@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 29, 2014 at 05:36:57PM -0700, Greg Kroah-Hartman wrote:
> Ugh, that's my fault, I made a typo and should not have renamed the
> sysfs file, very sorry about that.
> 
> I'll work on making up a patch to fix this and get it into the stable
> kernels so that you don't have to have a work-around for very long.

Thank you!  I appreciate your quick response.

Jeff
