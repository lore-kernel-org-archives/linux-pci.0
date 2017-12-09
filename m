Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 9 Dec 2017 09:00:08 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 0/9] remove some of unneeded kallsyms includes
Message-ID: <20171209000008.GF489@tigerII.localdomain>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208142442.7c09406d7f0bc3d2c1bfe411@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208142442.7c09406d7f0bc3d2c1bfe411@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On (12/08/17 14:24), Andrew Morton wrote:
> On Fri,  8 Dec 2017 11:56:07 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > 	A small patch set that removes some kallsyms includes
> > here and there. Mostly those kallsyms includes are leftovers:
> > printk() gained %pS/%pF modifiers support some time ago, so
> > print_symbol() and friends became sort of unneeded [along with
> > print_fn_descriptor_symbol() deprecation], thus some of the
> > users were converted to pS/pF. This patch set just cleans up
> > that convertion.
> > 
> > 	We still have a number of print_symbol() users [which
> > must be converted to ps/pf, print_symbol() uses a stack buffer
> > KSYM_SYMBOL_LEN to do what printk(ps/pf) can do], but this is
> > out of scope.
> > 
> > 	I compile tested the patch set; but, as always and
> > usual, would be great if 0day build robot double check it.
> 
> I grabbed everything and shall drop any patches which later turn up in
> the various subsystem trees.

thank you!

	-ss
