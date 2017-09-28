Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Sep 2017 11:26:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Govindarajulu Varadarajan <gvaradar@cisco.com>
Cc: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com
Subject: Re: [PATCH 4/4] lockdep: make MAX_LOCK_DEPTH configurable from
 Kconfig
Message-ID: <20170928092600.qvehxzikcjr65hvw@hirez.programming.kicks-ass.net>
References: <20170927214220.41216-1-gvaradar@cisco.com>
 <20170927214220.41216-5-gvaradar@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927214220.41216-5-gvaradar@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 27, 2017 at 02:42:20PM -0700, Govindarajulu Varadarajan wrote:
> Make MAX_LOCK_DEPTH configurable. It is set to 48 right now. Number of
> VFs under a PCI pf bus can exceed 48 and this disables lockdep.
> 
> lockdep currently allows max of 63 held_locks.

But why a config knob? Why not just raise the number to 64
unconditionally? And is that sufficient; you only state 48 is
insufficient, you don't actually state the VF limit.
