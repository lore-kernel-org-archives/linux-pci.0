Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 May 2018 10:46:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Jes Sorensen <jsorensen@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Tai <thomas.tai@oracle.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure
 for AER capable devices
Message-ID: <20180523104636.55303f16@gandalf.local.home>
In-Reply-To: <ffa4e203-f320-b9be-c0d7-8432e949765b@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
        <20180522222805.80314-2-rajatja@google.com>
        <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
        <20180523142656.GE19987@bombadil.infradead.org>
        <46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
        <ffa4e203-f320-b9be-c0d7-8432e949765b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 23 May 2018 09:33:30 -0500
"Alex G." <mr.nuke.me@gmail.com> wrote:

> > Well I'll agree to disagree with Linus on this one. It's ugly as fsck
> > and allows for ambiguous statements in the code.  
> 
> You misspelled "fuck".

No, Jes is Danish. That's how they spell it.

-- Steve
