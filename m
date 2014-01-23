Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35523 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbaAWTzJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 14:55:09 -0500
Date: Thu, 23 Jan 2014 11:55:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Jones <davej@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [scan-admin@coverity.com: New Defects reported by Coverity Scan
 for Linux]
Message-ID: <20140123195559.GA12053@kroah.com>
References: <20140123184246.GA7461@google.com>
 <20140123193405.GB2605@kroah.com>
 <20140123194631.GA9269@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140123194631.GA9269@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 02:46:31PM -0500, Dave Jones wrote:
> On Thu, Jan 23, 2014 at 11:34:05AM -0800, Greg Kroah-Hartman wrote:
>  > On Thu, Jan 23, 2014 at 11:42:46AM -0700, Bjorn Helgaas wrote:
>  > > FYI.  I think the first two (related to "name") are valid.  I haven't
>  > > figured out the "msi_attrs" one yet.
>  > 
>  > I've send a fix for the first two to you now, that should resolve this
>  > issue.
>  > 
>  > But the last one, I can't figure out either.  I think Coverity doesn't
>  > realize that we saved off the pointer and can get back to it later on,
>  > as it's a non-trivial pointer chain involved here.
> 
> This is in the error path though, where we're tearing down all that stuff
> we just built up, so there is no 'later on' afaict.  If we took one of the
> error_* branches, we're not storing this for anything to free later.
> 
> I've only looked at this quickly, but it looks valid to me.
> 
> it looks like we're freeing the contents of the array, but not the array itself.

Doh, you are right, I missed that, thanks, I'll go send a fix for this.

greg k-h
