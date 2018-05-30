Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Wed, 30 May 2018 00:44:29 -0700
From: okaya@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <20180530073735.GA28793@infradead.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180530073735.GA28793@infradead.org>
Message-ID: <6dfe2db8f974d94c9867f30ec83d9333@codeaurora.org>
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

On 2018-05-30 00:37, Christoph Hellwig wrote:
> On Tue, May 29, 2018 at 09:41:33PM -0700, Sinan Kaya wrote:
>> Bjorn and I discussed the need for such a "safe" mode feature when you
>> want to bring up PCI for a platform. You want to turn off everything 
>> as
>> a starter and just stick to bare minimum.
> 
> Can we please make it a config option the instead of adding code
> to every kernel?  Also maybe the bringup should be in the name
> to make this more clear?

One other requirement was to have a runtime option rather than compile 
time option.

When someone reported a problem, we wanted to be able to say "use this 
option and see if system boots" without doing any bisects or 
recompilation.

This would be the first step in troubleshooting a system to see if 
fundamental features are working.

I don't mind changing the name
Bjorn mentioned safe option. I made it safemode. I am looking at Bjorn 
for suggestions at this moment.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
