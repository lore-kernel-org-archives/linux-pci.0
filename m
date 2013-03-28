Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo4ncW8rkcpDiccORZedj30m7jRmpXK+amfDGn_wjwt7EA@mail.gmail.com>
References: <CAE9FiQXmeb66dc8fET0y99BjqpUXp11c7utiQ5keR1Wf+N9xaA@mail.gmail.com>
	<1363628226-6679-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6v0mj9=Q13d=G4hho0mb9XTcsmefzke9fROYmZ7oBWxQ@mail.gmail.com>
	<CAE9FiQU7cDzJdHxmqhJNgc9UCsRLgvCFQpv8+fLxD79pLEUC5A@mail.gmail.com>
	<CAErSpo4ncW8rkcpDiccORZedj30m7jRmpXK+amfDGn_wjwt7EA@mail.gmail.com>
Date: Thu, 28 Mar 2013 13:24:08 -0700
Message-ID: <CAE9FiQVqKag2TGah7x_1MAJ+c0UWgywgM_jKUoOnh+rq3bwBhg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Remove not needed check in disable aspm link
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Roman Yepishev <roman.yepishev@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

resending with adding To Roman.

On Thu, Mar 28, 2013 at 5:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This patch might be *safe*, but it (and the changelog) are completely
> unintelligible.
>
> The problem with applying an unintelligible stop-gap patch is that it
> becomes forever part of the changelog, and it's a huge waste of time
> to everybody who tries to understand the history later.  That's why I
> think it's worth spending some time to make a good patch now.

Please check if attached patch is doing what you want.

Thanks

Yinghai
