Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 21 Sep 2016 12:31:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
Message-ID: <20160921173129.GA20006@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
 <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
 <20160921131107.GB10804@localhost>
 <25529f96-3e80-0524-82d8-6eeb517df5b5@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <25529f96-3e80-0524-82d8-6eeb517df5b5@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, gabriele.paoloni@huawei.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, will.deacon@arm.com, wangyijing@huawei.com,
 andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org,
 Tomasz Nowicki <tn@semihalf.com>, linaro-acpi@lists.linaro.org,
 ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, liudongdong3@huawei.com, msalter@redhat.com,
 Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com, cov@codeaurora.org,
 mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, hanjun.guo@linaro.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 10:07:36AM -0400, Sinan Kaya wrote:
> On 9/21/2016 9:11 AM, Bjorn Helgaas wrote:
> > On Tue, Sep 20, 2016 at 09:15:14PM -0400, cov@codeaurora.org wrote:
> >> Hi Bjorn, Thomasz,
> >>
> 
> >>
> >> Did you delete this because there were no current users, because you'd
> >> prefer users just use "-1", or for some other reason?
> > 
> > I removed it because there were no users of it and, more importantly,
> > the code doesn't implement support for it.
> 
> Is it possible to queue up Cov's patch as part of this effort once he 
> rebases and sends an updated version? Cov will have to implement something
> else now.

I haven't see Cov's patch (patchwork doesn't follow URLs to git trees,
and I normally don't either).  If they show up on the mailing list,
I'll take a look, of course.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
