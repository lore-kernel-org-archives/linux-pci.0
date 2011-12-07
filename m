Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4EDF2152.1090005@jp.fujitsu.com>
References: <20111123144417.2da5958c@jbarnes-desktop>
	<CA+55aFyaiJBYmgVCLfPA7q3hqtPHYh9wwsmVTCewbBoxMsDE8A@mail.gmail.com>
	<20111205112256.68e59434@jbarnes-desktop>
	<4EDDCD6D.1010907@jp.fujitsu.com>
	<CA+55aFwuZxGZhXyhj+cb5WLnFPDh45Dy6BwgmvEQKAM5swaM6w@mail.gmail.com>
	<CAE9FiQXwTcvfH21QZ87rU2vgf-xo8OT8L3f5gYwtbxJUDkDatQ@mail.gmail.com>
	<4EDF2152.1090005@jp.fujitsu.com>
Date: Wed, 7 Dec 2011 11:20:44 -0800
Message-ID: <CAE9FiQXRAXybo3ASZkGZpYZGf0yb-g8=7UX6iqAvcqBOpSRaKw@mail.gmail.com>
Subject: Re: [git pull] PCI fixes
From: Yinghai Lu <yinghai@kernel.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 7, 2011 at 12:18 AM, Kenji Kaneshige
<kaneshige.kenji@jp.fujitsu.com> wrote:
> +       /* Configuration request Retry Status */
> +       if (l == 0xffff0001)
> +               goto wait;
>
> I think this works only when CRS Software Visibility is enabled,
> isn't it? Currently there is no code to enable CRS Software
> Visibility. And there can be root ports that doesn't support CRS
> Software Visibility. We need consideration about this.

I copied and change from pci_scan_device...

/*
 * Read the config data for a PCI device, sanity-check it
 * and fill in the dev structure...
 */
static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
{
        struct pci_dev *dev;
        u32 l;
        int delay = 1;

        if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
                return NULL;

        /* some broken boards return 0 or ~0 if a slot is empty: */
        if (l == 0xffffffff || l == 0x00000000 ||
            l == 0x0000ffff || l == 0xffff0000)
                return NULL;

        /* Configuration request Retry Status */
        while (l == 0xffff0001) {
                msleep(delay);
                delay *= 2;
                if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
                        return NULL;
                /* Card hasn't responded in 60 seconds?  Must be stuck. */
                if (delay > 60 * 1000) {
                        printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not "
                                        "responding\n", pci_domain_nr(bus),
                                        bus->number, PCI_SLOT(devfn),
                                        PCI_FUNC(devfn));
                        return NULL;
                }
        }

so CRS code is not removed cleanly?

>
> +       mdelay(100);
> +       delay -= 100;
> +       if (delay > 0)
> +               goto again;
>
> We must use msleep() instead of mdelay().

yes.

Thanks

Yinghai Lu
