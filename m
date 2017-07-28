Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
To: "Raj, Ashok" <ashok.raj@intel.com>, Casey Leedom <leedom@chelsio.com>
References: <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAKgT0UeAad6WArvrE71MFJywDs1wOnCF-iJRnbNLrL+knqhXeA@mail.gmail.com>
 <CAKgT0Uf5hdXUXja_jUB6_kBg6pyX8zXuOMOGzCVNgeBFMUsWqQ@mail.gmail.com>
 <CAKgT0Udn2vh6NaqZyiF69nXVnz2sT=e0ZgiDjWznhGZz-Gk+qQ@mail.gmail.com>
 <MWHPR12MB16007782C422082A92F4765DC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <2feff1a5-25b7-eb6c-7628-7c2257c56e95@huawei.com>
 <MWHPR12MB1600556FFDCE3EC810D97591C8BE0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20170727184251.GA205508@otc-nc-03>
From: Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <3e8a1756-86ca-0fa0-7119-b0bdfe806e8e@huawei.com>
Date: Fri, 28 Jul 2017 10:57:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170727184251.GA205508@otc-nc-03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "asit.k.mallick@intel.com" <asit.k.mallick@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Sinan Kaya <okaya@codeaurora.org>,
 "amira@mellanox.com" <amira@mellanox.com>, Bjorn Helgaas <helgaas@kernel.org>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Ganesh GR <ganeshgr@chelsio.com>, "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Michael Werner <werner@chelsio.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David.Laight@aculab.com" <David.Laight@aculab.com>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 2017/7/28 2:42, Raj, Ashok wrote:
> Hi Casey
> 
>> | Still no Intel and AMD guys has ack this, this is what I am worried about,
>> | should I ping some man again ?
> 
> 
> I can ack the patch set for Intel specific changes. Now that the doc is made
> public :-).
> 

Good, Thanks. :)

> Can you/Ding resend the patch series, i do have the most recent v7, some
> of the commit message wasn't easy to ready. Seems like this patch has
> gotten bigger than originally intended, but seems to be for the overall
> good :-).
> 

OK, I will send v8 patch set and which will update the patch title and add
Casey's new modification for his vf driver, thanks.

Ding

> Sorry for staying silent up until now.
> 
> Cheers,
> Ashok
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
