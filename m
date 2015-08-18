Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150817235307.GR26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-10-git-send-email-yinghai@kernel.org>
	<20150817235307.GR26431@google.com>
Date: Tue, 18 Aug 2015 14:36:44 -0700
Message-ID: <CAE9FiQVjSQE6w4A2e3Fr88eDv6aDotbuo3NSenCJdaUOY9eWwQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/51] PCI: Rename pdev_sort_resources to pdev_check_resources
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 4:53 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:27PM -0700, Yinghai Lu wrote:
>> We don't do sorting in those functions anymore, so change "sort" to "check"
>> instead.
>
> What *do* we do in those functions?  "Check" doesn't tell me anything.

Put all children devices' resources that need to assign in one list, and also
do some sanitary checking like if align is good or not.
