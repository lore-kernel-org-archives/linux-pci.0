Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Sep 2014 12:20:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/11 UPDATE] cpumask: factor out show_cpumap into
 separate helper function
Message-ID: <20140924102016.GW16043@twins.programming.kicks-ass.net>
References: <1409763617-17074-2-git-send-email-sudeep.holla@arm.com>
 <1409845592-27739-1-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409845592-27739-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 04, 2014 at 04:46:32PM +0100, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Many sysfs *_show function use cpu{list,mask}_scnprintf to copy cpumap
> to the buffer aligned to PAGE_SIZE, append '\n' and '\0' to return null
> terminated buffer with newline.
> 
> This patch creates a new helper function cpumap_print_to_pagebuf in
> cpumask.h using newly added bitmap_print_to_pagebuf and consolidates
> most of those sysfs functions using the new helper function.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
