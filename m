Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448314314.15591.1.camel@oracle.com>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
	<5633E570.6040906@oracle.com>
	<CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
	<1448314314.15591.1.camel@oracle.com>
Date: Mon, 23 Nov 2015 18:39:14 -0800
Message-ID: <CAE9FiQWiWvOuW3gKRKSDWwPTzNAE7w=u2UiA=XSAXMscxJe2SQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
From: Yinghai Lu <yinghai@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 23, 2015 at 1:31 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>> Looks like only the device BAR6 is not assigned form OF?
>
> Any progress on this? Do you need any more information from me?

Should be one warning about this device in that system.

We don't need to do anything about it if the device is working with
this patch set.

Thanks

Yinghai
