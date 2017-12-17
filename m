Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Len Brown <len.brown@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 3/9] power: remove unneeded kallsyms include
Date: Sun, 17 Dec 2017 19:04:16 +0100
Message-ID: <4033333.ijW7uRe5gx@aspire.rjw.lan>
In-Reply-To: <20171208144844.GA489@tigerII.localdomain>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com> <CAJZ5v0g1CBhKTYi=CzYPcBXdH=yZ3iJcKzZ6TaftNWoq+X5wnQ@mail.gmail.com> <20171208144844.GA489@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 8, 2017 3:48:44 PM CET Sergey Senozhatsky wrote:
> On (12/08/17 15:01), Rafael J. Wysocki wrote:
> > On Fri, Dec 8, 2017 at 3:56 AM, Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com> wrote:
> > > The file was converted from print_fn_descriptor_symbol()
> > > to %pF some time ago (c80cfb0406c01bb "vsprintf: use new
> > > vsprintf symbolic function pointer format"). kallsyms does
> > > not seem to be needed anymore.
> > >
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Cc: Rafael Wysocki <rjw@rjwysocki.net>
> > > Cc: Len Brown <len.brown@intel.com>
> > > ---
> > >  drivers/base/power/main.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 5bc2cf1f812c..e2539d8423f7 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -18,7 +18,6 @@
> > >   */
> > >
> > >  #include <linux/device.h>
> > > -#include <linux/kallsyms.h>
> > >  #include <linux/export.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/pm.h>
> > > --
> > 
> > Do you want me to apply this or do you want to route it differently?
> 
> Hello Rafael,
> 
> don't mind if you'll pick it up.

OK, applied now.

Thanks!
