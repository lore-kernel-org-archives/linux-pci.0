Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Sep 2013 15:09:43 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>
Subject: Re: [PATCH 5/9] PCI/MSI/s390: Make return values only 0/-errno when
 MSIs allocated
Message-ID: <20130910130943.GA6980@dhcp-26-207.brq.redhat.com>
References: <20130905154041.GD30984@dhcp-26-207.brq.redhat.com>
 <20130905154436.GC24148@htj.dyndns.org>
 <20130905185440.GA13175@dhcp-26-207.brq.redhat.com>
 <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130909152658.GG24962@dhcp-26-207.brq.redhat.com>
 <522F13A9.9020704@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <522F13A9.9020704@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 10, 2013 at 04:42:17PM +0400, Sergei Shtylyov wrote:
>    This contradicts to the patch subject.

Sorry, Sergei et al.
I screwed this series is bit. The second 5/9 fixes that.

> WBR, Sergei
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
