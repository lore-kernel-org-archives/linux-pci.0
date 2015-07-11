Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jul 2015 08:03:28 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
Message-ID: <20150711000328.GA7498@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
 <1436225966-27247-37-git-send-email-yinghai@kernel.org>
 <20150709033030.GA7079@richard>
 <CAE9FiQVSK9kAg-qyASpb1AoHSwQbKK33eHhFmzUjoLOftK9M4w@mail.gmail.com>
 <20150709060420.GA7465@richard>
 <CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
 <20150710023014.GA16104@richard>
 <CAE9FiQVaoFWk9A1vyqDgOu_eqWRcZkwrWRQ0CXpcAJ4VBOgwaQ@mail.gmail.com>
 <CAE9FiQWiCZB0EvQ2RNujdD1-0pRO_izJrqBwExaK9Md1d5wCjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWiCZB0EvQ2RNujdD1-0pRO_izJrqBwExaK9Md1d5wCjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 09, 2015 at 10:49:06PM -0700, Yinghai Lu wrote:
>On Thu, Jul 9, 2015 at 7:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Jul 9, 2015 at 7:30 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>>> If you could update your for-pci-v4.3-next branch, that would be more
>>> convenient for me to do the test.
>>
>> Just updated that branch, please check it.
>>
>
>just updated the branch again.
>
>If you don't want to re get it again, please apply attached patch.

Yinghai,

I have tested you latest branch with this one as the last commit:

ec94cc7 PCI: Don't set flags to 0 when assign resource fail

My P8 machine boots up.

Another issue is the SRIOV couldn't be enabled, I am checking the reason. 
This may not related to this patch series.

