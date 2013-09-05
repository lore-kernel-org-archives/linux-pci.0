Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 Sep 2013 17:25:39 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 5/6] AHCI: Check MRSM bit when multiple MSIs enabled
Message-ID: <20130905152539.GC30984@dhcp-26-207.brq.redhat.com>
References: <cover.1378383792.git.agordeev@redhat.com>
 <4bc31d6ccf3f84399b977fe8ed4fe77aadfa1c79.1378383792.git.agordeev@redhat.com>
 <20130905131149.GC26314@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130905131149.GC26314@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 05, 2013 at 09:11:49AM -0400, Tejun Heo wrote:
> On Thu, Sep 05, 2013 at 02:54:17PM +0200, Alexander Gordeev wrote:
> The patch should probably be re-sequenced to the head of the series
> and cc stable@vger.kernel.org.  Not checking MRSM is scary.

Will resend v3.

> Thanks.
> 
> -- 
> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
