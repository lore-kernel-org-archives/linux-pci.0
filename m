Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:36199 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbbGKGsA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jul 2015 02:48:00 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Sat, 11 Jul 2015 07:07:17 +0530
Date: Sat, 11 Jul 2015 09:37:10 +0800
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
Message-ID: <20150711013710.GA24488@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1436225966-27247-37-git-send-email-yinghai@kernel.org>
 <20150709033030.GA7079@richard>
 <CAE9FiQVSK9kAg-qyASpb1AoHSwQbKK33eHhFmzUjoLOftK9M4w@mail.gmail.com>
 <20150709060420.GA7465@richard>
 <CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
 <20150710023014.GA16104@richard>
 <CAE9FiQVaoFWk9A1vyqDgOu_eqWRcZkwrWRQ0CXpcAJ4VBOgwaQ@mail.gmail.com>
 <CAE9FiQWiCZB0EvQ2RNujdD1-0pRO_izJrqBwExaK9Md1d5wCjw@mail.gmail.com>
 <20150711000328.GA7498@richard>
 <CAE9FiQUS=NV4_2vuHN2j3N07sEaD2=XaYASDdCz+UQMSiqmqRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUS=NV4_2vuHN2j3N07sEaD2=XaYASDdCz+UQMSiqmqRQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 10, 2015 at 05:42:10PM -0700, Yinghai Lu wrote:
>On Fri, Jul 10, 2015 at 5:03 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Thu, Jul 09, 2015 at 10:49:06PM -0700, Yinghai Lu wrote:
>
>> I have tested you latest branch with this one as the last commit:
>>
>> ec94cc7 PCI: Don't set flags to 0 when assign resource fail
>>
>> My P8 machine boots up.
>
>Good.
>
>>
>> Another issue is the SRIOV couldn't be enabled, I am checking the reason.
>> This may not related to this patch series.
>
>wonder if could be related to :
>
>https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=c642f79dcd6becbb92741816e0b5e81f7664acc7
>PCI: Restore pref mmio allocation logic for hostbridge without mmio64
>

Looks no.

I have tried to revert all your patches, still not work. Need to get more time
to investigate.

>Yinghai

-- 
Richard Yang
Help you, Help me

