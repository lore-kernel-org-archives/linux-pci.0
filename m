Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <mj+md-20131215.091609.28546.nikam@ucw.cz>
References: <1378302428-19758-1-git-send-email-teg@jklm.no>
 <mj+md-20130904.134928.12262.nikam@ucw.cz> <CAG-2HqWcnZ-z7EbDd0aAj6y_Ho6szfRZUiK0psEnmoz17Kw-xA@mail.gmail.com>
 <mj+md-20131110.114139.9646.albireo@ucw.cz> <CAG-2HqXsEBB_nxUF4gza-eTsUjmysYR7iPEjJPUFyR1rC2KGMg@mail.gmail.com>
 <CAPXgP12MLL_Z5gyrCndQLRT6SR_TJi9xHp1HkHMX1ahwnxx3yw@mail.gmail.com> <mj+md-20131215.091609.28546.nikam@ucw.cz>
From: Kay Sievers <kay@vrfy.org>
Date: Sun, 15 Dec 2013 10:49:24 +0100
Message-ID: <CAPXgP10+1WtX8_xN+QSHvKws01hbKhP3FN95sXk9EtezdSPtqg@mail.gmail.com>
Subject: Re: [PATCH RESEND][pciutils] libpci: pci_id_lookup - add udev/hwdb support
To: Martin Mares <mj@ucw.cz>
Cc: Tom Gundersen <teg@jklm.no>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 15, 2013 at 10:18 AM, Martin Mares <mj@ucw.cz> wrote:
> Hello Kay,
>
>> Libpci and its linear search through megabytes of text files for evey
>> new query is too inefficient, that we cannot afford to use it during
>> early bootup. It was the largest hit left in bootup profiling on
>> machines booting userspace in the sub-1-second range on common
>> machines. It was probably never meant to provide efficient queries,
>> but it's the reason we can never use it during early boot.
>
> I do not know what you are speaking about -- libpci definitely does
> not perform linear scans on pci.ids. It builds a hash table from pci.ids
> on the first query and and all subsequent queries are O(1) on average.

It does that per process doing that, and that's the problem for how
udev works/worked. The binary hwdb is on-disk and can be mmaped, and
there is no difference between initialization, first, or subsequent
queries.

Kay
