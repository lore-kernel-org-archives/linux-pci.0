Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33097 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbGJFtH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2015 01:49:07 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVaoFWk9A1vyqDgOu_eqWRcZkwrWRQ0CXpcAJ4VBOgwaQ@mail.gmail.com>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
	<1436225966-27247-37-git-send-email-yinghai@kernel.org>
	<20150709033030.GA7079@richard>
	<CAE9FiQVSK9kAg-qyASpb1AoHSwQbKK33eHhFmzUjoLOftK9M4w@mail.gmail.com>
	<20150709060420.GA7465@richard>
	<CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
	<20150710023014.GA16104@richard>
	<CAE9FiQVaoFWk9A1vyqDgOu_eqWRcZkwrWRQ0CXpcAJ4VBOgwaQ@mail.gmail.com>
Date: Thu, 9 Jul 2015 22:49:06 -0700
Message-ID: <CAE9FiQWiCZB0EvQ2RNujdD1-0pRO_izJrqBwExaK9Md1d5wCjw@mail.gmail.com>
Subject: Re: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
From: Yinghai Lu <yinghai@kernel.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary=089e013c69d2196c36051a7eeeeb
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--089e013c69d2196c36051a7eeeeb
Content-Type: text/plain; charset=UTF-8

On Thu, Jul 9, 2015 at 7:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jul 9, 2015 at 7:30 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> If you could update your for-pci-v4.3-next branch, that would be more
>> convenient for me to do the test.
>
> Just updated that branch, please check it.
>

just updated the branch again.

If you don't want to re get it again, please apply attached patch.

--089e013c69d2196c36051a7eeeeb
Content-Type: text/x-patch; charset=US-ASCII; name="resource_disabled_fix.patch"
Content-Disposition: attachment; filename="resource_disabled_fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibx7div30

LS0tCiBkcml2ZXJzL3BjaS9idXMuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9idXMu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9idXMuYworKysgbGlu
dXgtMi42L2RyaXZlcnMvcGNpL2J1cy5jCkBAIC0xNDAsNyArMTQwLDcgQEAgc3RhdGljIGludCBw
Y2lfYnVzX2FsbG9jX2Zyb21fcmVnaW9uKHN0cgogCXR5cGVfbWFzayB8PSBJT1JFU09VUkNFX1RZ
UEVfQklUUzsKIAogCXBjaV9idXNfZm9yX2VhY2hfcmVzb3VyY2UoYnVzLCByLCBpKSB7Ci0JCWlm
ICghcikKKwkJaWYgKCFyIHx8IHJlc291cmNlX2Rpc2FibGVkKHIpKQogCQkJY29udGludWU7CiAK
IAkJLyogdHlwZV9tYXNrIG11c3QgbWF0Y2ggKi8K
--089e013c69d2196c36051a7eeeeb--
