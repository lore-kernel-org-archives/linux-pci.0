Return-Path: <mhocko@kernel.org>
Return-Path: <mhocko@kernel.org>
Date: Tue, 19 Jun 2018 17:14:25 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Xie XiuQi <xiexiuqi@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>, tnowicki@caviumnetworks.com,
	linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	linux-mm@kvack.org, wanghuiqiang@huawei.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	zhongjiang <zhongjiang@huawei.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
Message-ID: <20180619151425.GH13685@dhcp22.suse.cz>
References: <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
 <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
 <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
 <20180619120714.GE13685@dhcp22.suse.cz>
 <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
 <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
 <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
[...]
> In terms of $SUBJECT, I wonder if it's worth taking the original patch
> as a temporary fix (it'll also be easier to backport) while we work on
> fixing these other issues and enabling memoryless nodes.

Well, x86 already does that but copying this antipatern is not really
nice. So it is good as a quick fix but it would be definitely much
better to have a robust fix. Who knows how many other places might hit
this. You certainly do not want to add a hack like this all over...
-- 
Michal Hocko
SUSE Labs
