Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Sat, 02 Jun 2018 13:57:19 -0400
From: okaya@codeaurora.org
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <20180602174307.GB14870@amd>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180602174307.GB14870@amd>
Message-ID: <f3d6c44829910cb09c6f72dba1c41b39@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Ingo Molnar <mingo@kernel.org>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Dongdong Liu <liudongdong3@huawei.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Frederick Lawler <fred@fredlawl.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Oza Pawandeep <poza@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-02 13:43, Pavel Machek wrote:
> Hi!
> 
>> > And you should explain what exactly in PCI is "optional".  Who defines
>> > this and where is that list and what can go wrong if those options are
>> > not enabled?
>> 
>> Bjorn and I discussed the need for such a "safe" mode feature when you
>> want to bring up PCI for a platform. You want to turn off everything 
>> as
>> a starter and just stick to bare minimum.
>> 
>> I can add a few words describing them. The goal of this option is to 
>> keep
>> base PCI features with MSI only. Things like PME, AER, ASPM, Extended
>> Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. 
>> safemode
>> is certainly not intended for production environments.
>> 
>> I can taint the kernel as a suggestion.
> 
> I don't think tainting is required. even modern platforms should work
> in the safe mode.

Yeah, concern was getting used to the safe mode and never running the 
full stack to fix the actual issues like getting away with crappy 
hardware and firmware.

It becomes a support issue for the community.


> 									Pavel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
