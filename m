Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Apr 2013 06:28:31 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Veaceslav Falico <vfalico@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH] module: add kset_obj_exists() and use it
Message-ID: <20130411132831.GC2909@kroah.com>
References: <1365506529-8396-1-git-send-email-vfalico@redhat.com>
 <87y5cq6ei9.fsf@rustcorp.com.au>
 <20130411095537.GC21320@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130411095537.GC21320@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 11, 2013 at 11:55:37AM +0200, Veaceslav Falico wrote:
> However, I think my patch still adds something good, cause now we have 2
> cases where we basically do:
> 
> k = kset_find_obj();
> if (!k)
> 	return;
> kobject_put(k);
> 
> which adds useless overhead (by using kobject_get()/kobject_put(), and
> kobject_release() - which is called from kobject_put()) - where we should
> only verify if there exists a kobject with the specified name.
> 
> Should I resend it with a properly fixed commit message, or it's really not
> needed?

I don't think it's really needed, there is no speed/overhead issue here
and you need to do the kobject_get/put stuff anyway if you are trying to
look at a kobject.

thanks,

greg k-h
