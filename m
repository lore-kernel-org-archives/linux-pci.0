Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Dec 2015 15:10:42 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatxjain@gmail.com>
Cc: Rajat Jain <rajatja@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] kobject: Ensure child's resources get released before
 parent's resources
Message-ID: <20151214231042.GC24613@kroah.com>
References: <1450119766-28102-1-git-send-email-rajatja@google.com>
 <20151214214022.GA24226@kroah.com>
 <CAA93t1roq4xmeqHjTSKsrO-8VKiRN0aK4_LU1p3pQLGicWy7fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA93t1roq4xmeqHjTSKsrO-8VKiRN0aK4_LU1p3pQLGicWy7fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 14, 2015 at 02:33:46PM -0800, Rajat Jain wrote:
> On Mon, Dec 14, 2015 at 1:40 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Dec 14, 2015 at 11:02:46AM -0800, Rajat Jain wrote:
> >> If the only remaining reference to a parent, is the one taken by
> >> the child (in kobject_add_internal()), then when the last
> >> reference to the child goes away, both child and its parents
> >> shall be released. However, currently the resources of parent
> >> get released first, followed by the child's resources:
> >>
> >> kobject_cleanup(child)
> >>     ....
> >>     kobject_del(child)
> >>         ....
> >>         kobject_put(child->parent) -> results in parent's release()
> >>         ...
> >>     child->kobj_type->release() -> Child's release()
> >>
> >> This is a problem because the child's release() method may still
> >> need to use parent resources or memory for its own cleanup. E.g.
> >> child may need parent pointer for dma_free_coherent() etc.
> >>
> >> Signed-off-by: Rajat Jain <rajatja@google.com>
> >> Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
> >
> > Why are you listed twice here?
> 
> Ah, sorry, I'll remove that.
> 
> >
> > Where in the kernel is the parent being freed before the child that is
> > causing this issue to happen?  We should fix that root cause first...
> 
> Umm, are you saying that it is a bug to reach a scenario where all
> references to a parent, except the ones made by the child, are gone?
> 
> Sorry, I should have given more context here. Here is the scenario
> where I came across this situation, and I'd appreciate any suggestions
> on how to better deal with this situation:
> 
> I have 2 modules (random names here):
> 
> user_interface.ko <--- pci_driver.ko

Don't use random names, use real ones of existing drivers so we can see
what is happening here.

> 1) user_interface.ko
>      - exports some interfaces (char driver etc) to the userspace,

The specific type of interface is key here.

>      - allows low-level device drivers to register devices via some
> API (user_interface_add() / user_interface_del())

It better do so in a way that prevents itself from being unloaded...

>      - Userspace can issue some transactions. Each transaction results
> in a child kobject being attached to the device's kobject.

What?

What "child kobject"?  What "transaction" is being attached?  That's not
what kobjects are for.

Please post the code you are doing this with please.

>      - Low level drivers also provide a release() function that can
> get called AFTER user_interface_del() if there are transactions
> in-flight.

Then that's a stupid interface, fix it!  :)

>      - Low level drivers should allow operation of the device until
> release() gets called.

Nope, again, broken interface, fix it.

> 2) Low level drivers such as pci_driver.ko:
>     - attach to the actual physical devices (PCI device in this case)
>     - create a custom device (that has an embedded "struct device")
> and register this new custom device with the user_interface.ko.

That's odd, and not normal, you shouldn't be passing your device off to
anything else.  Where in the code does it do this?

>     - also attaches a release() function to the device. This release()
> would get called when all references to the device are dropped.

That release better be somewhere that is properly reference counted...

>     - The entities holding the reference to the device are:
>           * 1 reference by the pci_driver.ko itself (when it did
> device_initialize())
>           * 1 reference by the user_interface.ko (During user_interface_add())

Ick, no, broken interface.

>           * 1 reference for each transaction in-flight (a child
> kobject under the device)

Again, ick, no, broken interface, fix your code.  That's not how you
should design things.

> 3) Now, we want to allow removing (rmmod) the low level driver pci_driver.ko.

No you do not, don't do that.  End of story :)

Please post your example code, it's really designed poorly, we can fix
that up.

thanks,

greg k-h
